require "api_documentation_helper"

RSpec.resource "Players", :authenticated, :authorized do
  header "Content-Type", "application/vnd.api+json"

  post "/v1/players" do
    parameter :type, <<-DESC, required: true
      Must always be set to <code>players</code>.
    DESC

    let :type do
      "players"
    end

    parameter "user", <<-DESC, required: true, scope: :relationships
      The related user.
    DESC

    let! :user_id do
      FactoryGirl.create(:user).id.to_s
    end

    let "user" do
      {
        data: {
          id: user_id,
          type: "users"
        }
      }
    end

    parameter "name", <<-DESC, required: true, scope: :attributes
      The name of the player. Whatever you like!
    DESC

    let :name do
      "Barney"
    end

    parameter "avatar", <<-DESC, scope: :attributes
      The avatar of the player. Whatever you like!
    DESC

    let :avatar do
      "
/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBggGBQkIEhQQCRUKDRwWGRgXDRwTFBgiHCQhIB4THhsYJzIfGBovJR4mJjsmLyc1LDA4Fio9NzwqOjI3MzUBCQoKDQsNGQ4OGTUkHiQ1NTU1NTU1NTA1NTU1LzU1NTQ1NTQ0NC81MDE1NCk1LzQ0LjA1LDY0LDQ1NC80Lyw2Kf/AABEIADIAMgMBIgACEQEDEQH/xAAcAAEAAgMBAQEAAAAAAAAAAAAABQcBBAYDCAL/xAA2EAABAwMBAwoBDQAAAAAAAAABAAIDBAURBiFBYQcSFDFRUmJxgZKxEyIkQ3J0oaKywcLR8P/EABkBAAIDAQAAAAAAAAAAAAAAAAQGAAEDBf/EAB0RAAICAgMBAAAAAAAAAAAAAAEDAAIEERMxURL/2gAMAwEAAhEDEQA/ALxWvX10NtoJqt55rYWFx7fIcVsLj+VGqdBpRkQOPl6hrTxABd8QFqlfIwU9mOQziVa/gnE3vXd3u1S9zZH0bM7GRvLdnFw2uP4cFpUOq71b5myNnldg9TpC9p9HbFEomgJWK/IqNRNOQ21vo2O5eGldRR6ks7anAjew817ew9o8J/3UplVhyTVLm3itps7JIA7H2SBn8ys9LmWoKaajqNmE4vQL27hERCwyFyPKfRuqdKCUbejTtcfI5b8XBdcvKqpYq2klp3jntlaWkdoK1SzjYL+TF6+Vdqez57RSepLMLDfJqIPE4ZtB34O4+JaFPCaipjhBDTI4NyTgDOzJO4JsrYWr9DqJNqWrY0Pc7jkmpHOuldV7o4Qz3HP8VZqi9OWODT9mipG4eetzu849bvLcOAUolfKaHNNh1HHDSUJFD3CIiGhch77qu2aebiV3OeRkMaOc8+nUB5qub9yiXO7B0Mf0GM7mn5583f1hOUwEawfxhb+65RMGJiKFAwjZMV87NcWWWDoDyCcnPWiIunOTJyw6yulgcGsd8tGPq35LfTe302easjT+vbZfXsgOaSV+wMcdhPY13UfXB4Km1u2Tbf6D7yz9QQWRiKaDbWjOhi5zkkVB2PDL8RESzG6fh8UchyQHY7RlY6ND3W+0LCK9mVoTPRoe632hOjQ91vtCwimzJoTPRoe632hBBE0ghrRjwhEU2ZNCeiIiqXP/2Q=="
    end

    example_request "POST /v1/players" do
      expect(status).to eq 201
      parsed = JSON.parse(response_body)
      expect(parsed["data"]["relationships"]["user"]["data"]["id"]).to eq user_id
    end
  end

  get "/v1/players/:id" do
    let! :player do
      FactoryGirl.create(:player)
    end

    parameter :id, <<-DESC, required: true
      ID of the player to be retrieved.
    DESC

    let :id do
      player.id
    end

    example_request "GET /v1/players/:id" do
      expect(status).to eq 200
    end
  end

  get "/v1/players" do
    let! :player do
      FactoryGirl.create(:player, user: @user, name: "Barney")
    end

    example "GET /v1/players?filter[name]=" do
      explanation "This is a case insensitive search."
      do_request(filter: { name: "barney" })
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 1
    end

    example "GET /v1/players?sort=name" do
      explanation "Players may be sorted by name."
      player_two = FactoryGirl.create(:player, user: @user, name: "Alison")
      do_request(sort: "name")
      expect(JSON.parse(response_body)["data"][0]["id"]).to eq player_two.id.to_s
    end

    example "Filter by name and the player doesn't exist", document: false do
      do_request(filter: { name: "Fido"})
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 0
    end

    example_request "GET /v1/players" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 1
    end
  end

end
