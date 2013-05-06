module FlySouth

  Migration = Struct.new :file, :id, :tag do
    def to_s
      tag ? "#{id} (#{tag})" : id
    end
  end

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