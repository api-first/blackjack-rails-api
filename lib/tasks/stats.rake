task :stats => "app:stats_setup"

# insert additional types into the statistics table and sort the list
namespace :app do
  task :stats_setup do
    require 'rails/code_statistics'

    app_entries, spec_entries = [], []
    until ::STATS_DIRECTORIES.empty?
      entry = STATS_DIRECTORIES.shift
      case entry[0]
      when / specs/
        spec_entries << entry
      else
        app_entries << entry
      end
    end

    [
      ["Policies", "./app/policies"],
      ["Resources", "./app/resources"]
    ].each do |new_entry|
      index = 0
      app_entries.each do |entry|
        break if new_entry[0] < entry[0]
        index += 1
      end
      app_entries.insert(index - 1, new_entry)
    end

    ::STATS_DIRECTORIES.push *app_entries.sort
    ::STATS_DIRECTORIES.push *spec_entries.sort
  end
end
