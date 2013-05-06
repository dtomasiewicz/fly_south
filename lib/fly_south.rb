module FlySouth

  module Migrations

    def setup; end
    def teardown; end

    def before_each(migration); end
    def after_each(error); end

  end

  Migration = Struct.new :file, :id, :tag

end

require 'fly_south/runner'