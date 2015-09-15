class PlayerHandHistory

  attr_reader :player_scope, :table_scope, :position_scope

  def initialize(player_scope = Player.all, table_scope = Table.all, position_scope = :all)
    @player_scope = player_scope
    @table_scope = table_scope
    @position_scope = position_scope
  end

  def all
    leave_by_table_position_join = _build_leave_by_table_position_join

    return Hand.none if leave_by_table_position_join.empty?

    Hand.all.joins(:round).where(
      _where(leave_by_table_position_join),
      *_binds(leave_by_table_position_join)
    )
  end

  def _table_player_position_events
    scope = TablePlayerPositionEvent.where(
      table_id: table_scope.select(:id),
      player_id: player_scope.select(:id),
    )
    if position_scope != :all
      scope = scope.where(position: position_scope)
    end
    scope
  end

  def _where(leave_by_table_position_join = _build_leave_by_table_position_join)
    leave_by_table_position_join.map do |key, value|
      conditions = [
        "rounds.table_id = ?",
        "rounds.created_at >= ?",
        "hands.position = ?"
      ]
      conditions << "rounds.created_at > ?" if value
      "(" + conditions.join(" AND ") + ")"
    end.join(" OR ")
  end

  def _binds(leave_by_table_position_join = _build_leave_by_table_position_join)
    leave_by_table_position_join.map do |key, value|
      bind = [
        key[:table_id],
        key[:join],
        key[:position]
      ]
      bind << value if value
      bind
    end.flatten
  end

  def _build_leave_by_table_position_join
    leave_by_table_position_join = {}
    _table_player_position_events.where(event: TablePlayerPositionEvent.events["join"]).find_each do |table_player_position_event|
      leave_by_table_position_join[{
        table_id: table_player_position_event.table_id,
        position: table_player_position_event.position,
        join: table_player_position_event.created_at
      }] = nil
    end
    _table_player_position_events.where(event: TablePlayerPositionEvent.events["leave"]).find_each do |table_player_position_event|
      matching_join_at = nil
      leave_by_table_position_join.select do |key, value|
        key[:table_id] == table_player_position_event.table_id && key[:position] == table_player_position_event.position
      end.sort_by do |key, value|
        key[:join]
      end.each do |key, value|
        if key[:join] < table_player_position_event.created_at
          matching_join_at = key[:join]
        else
          break
        end
      end
      leave_by_table_position_join[{
        table_id: table_player_position_event.table_id,
        position: table_player_position_event.position,
        join: matching_join_at
      }] = table_player_position_event.created_at
    end
    leave_by_table_position_join
  end

end
