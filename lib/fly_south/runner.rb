module FlySouth

  class Runner

    attr_reader :versions, :current
    attr_writer :logger

    def initialize(versions, current)
      @versions, @current = versions.freeze, current
      extend Migrations
    end

    # returns number of successful migrations
    def migrate(delta)
      if delta == 0
        return
      elsif delta > 0 # up
        run = @versions[@current+1, delta]
      else # down
        run = @versions[@current+delta+1..@current].reverse!
      end

      setup

      begin
        run.each do |m|
          method = :"#{m.tag}_#{delta > 0 ? 'up' : 'down'}"
          log :info, "Migrating #{method} (#{m.id}) ..."
          
          require m.file

          if respond_to? method
            start = Time.now
            before_each m
            begin
              send method
            rescue Exception => e
              after_each e
              raise e
            end
            after_each nil
            log :info, "... completed (#{'%.2f' % (Time.now-start)})."
          else
            log :warn, "#{method} is not defined; ignoring"
            log :info, "... skipped."
          end
          @current += (delta <=> 0)
        end
      ensure
        teardown
      end
    end

    private

    def log(type, message)
      @logger.send type, message if @logger
    end

  end

end