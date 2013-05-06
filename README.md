# FlySouth

FlySouth is a simple Ruby framework for specifying and running _migrations_ -- a sequence of instructions which enable versioning of non-code entities, such as database schemas.

Because FlySouth is designed to be light-weight and extensible, it makes no assumptions about the entity you wish to version. As a result, features such as database adapters or abstractions are not included. Instead, FlySouth aims to give you a solid foundation on which to build your own versioning scheme.

## Installation

TODO

## Adding Migrations

Migrations are specified by defining methods in the `FlySouth::Migrations` module. All files containing migration code must be stored in a single directory, which contains no other `.rb` files. By default, FlySouth assumes this directory is named `migrations` and is found in the current working directory.

The name of each migration file consists of two parts, an identifier and a tag, separated by an underscore. The identifier is used for ordering, while the tag is used as a descriptive name.

For example, here is a simple migration which versions a text file, to be stored in `migrations/01_create_file.rb`.

    module FlySouth::Migrations

      def create_file_up
        File.new 'example.txt'
      end

      def create_file_down
        File.delete 'example.txt'
      end

    end

Now, running `migrate` will run the _up_ action, causing example.txt to be created. The process can be reversed by running the _down_ `migrate -v INITIAL`.

## Custom Runners

TODO

### Hooks

TODO