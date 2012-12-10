# see: https://github.com/middleman/middleman/issues/293

require 'guard/guard'

module ::Guard
  class Middleman < ::Guard::Guard
    def run_all
      system("bundle exec middleman build --clean")
    end

    def run_on_change(paths)
      system("bundle exec middleman build --clean")
    end
  end
end

guard 'middleman' do
  watch(/^source/)
end