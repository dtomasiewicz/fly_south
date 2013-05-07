module FlySouth

  class BaseRunner

    include Migrations

    attr_reader :versions, :current
    attr_writer :logger

    def initialize(versions, current)
      @versions, @current = versions.freeze, current
    end

    def version
      @versions[@current]
    end

    # returns true only if all migrations are successful
    def migrate(delta)
      if delta == 0
        return
      elsif delta > 0 # up
        run = @versions[@current+1, delta]
      else # down
        run = @versions[@current+delta+1..@current].reverse!
      end

      setup run

      error = nil
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
            rescue Exception => error
              break
            ensure
              after_each error
              log :info, "... #{error ? 'error' : 'completed'} (#{'%.2f' % (Time.now-start)})."
            end
          else
            log :warn, "#{method} is not defined; ignoring"
            log :info, "... skipped."
          end

          @current += (delta <=> 0)
        end
      rescue Exception => error
      ensure
        teardown error
      end

      !error
    end

    protected

    # hooks

    def setup(migrations)
    end

    def teardown(error)
      if error
        trace = error.backtrace.map{|l| "  #{l}"}.join "\n"
        log :error, "#{error.inspect}\n#{trace}"
      end
    end

    def before_each(migration)
    end

    def after_each(error)
      log :error, "#{error.inspect}" if error
    end

    def log(type, message)
      @logger.send type, message if @logger
    end

  end

end
