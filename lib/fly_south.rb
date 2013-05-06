module FlySouth

  Migration = Struct.new :file, :id, :tag

  module Migrations; end

  def self.runner
    @runner
  end

  def self.runner=(runner)
    @runner = runner
  end

end

require 'fly_south/base_runner'

FlySouth.runner = FlySouth::BaseRunner