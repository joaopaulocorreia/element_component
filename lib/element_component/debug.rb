# frozen_string_literal: true

module ElementComponent
  class Debugger
    attr_reader :events

    def initialize(output: nil, enabled: false)
      @events = []
      @output = output
      @enabled = enabled
    end

    def output
      @output || $stdout
    end

    def log(category, message, data = {})
      return unless @enabled

      entry = {
        time: Process.clock_gettime(Process::CLOCK_MONOTONIC),
        category: category,
        message: message,
        data: data
      }

      @events << entry
      output.puts format_entry(entry)

      entry
    end

    def enable!
      @enabled = true
    end

    def disable!
      @enabled = false
    end

    def enabled?
      @enabled
    end

    def clear!
      @events.clear
    end

    private

    def format_entry(entry)
      tag = entry[:category].to_s.upcase.rjust(12)
      data = entry[:data].empty? ? "" : "  #{entry[:data].inspect}"
      "[#{tag}] #{entry[:message]}#{data}"
    end
  end
end
