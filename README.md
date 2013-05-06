# FlySouth

FlySouth is a simple Ruby framework for specifying and running _migrations_ -- a sequence of instructions which enable versioning of non-code entities, such as database schemas.

Because FlySouth is designed to be light-weight and extensible, it makes no assumptions about the entity you wish to version. As a result, features such as database abstraction and SQL generation are not included. Instead, FlySouth aims to give you a solid foundation on which to build your own versioning scheme.

## Installation

TODO

## Example

Migrations are specified by defining methods in the `FlySouth::Migrations` module. All files containing migration code must be stored in a single directory, which contains no other `.rb` files. By default, FlySouth assumes this directory is named `migrations` and is found in the current working directory.

The name of each migration file consists of two parts, an identifier and a tag, separated by an underscore. The identifier is used for ordering, while the tag is used as a short description of the changes to be applied.

For example, here is a simple migration which versions a text file, to be stored in `migrations/1_create_file.rb`.

```ruby
module FlySouth::Migrations

  def create_file_up
    File.new 'example.txt'
  end

  def create_file_down
    File.delete 'example.txt'
  end

end
```

Executing `migrate` will run the _up_ action, causing example.txt to be created. The process can be reversed by running the _down_ action with `migrate -v INITIAL`.

Now, let's create a new version which adds a string of text to this file. The following is to be stored in `migrations/2_write_file.rb`.

```ruby
module FlySouth::Migrations

  def write_file_up
  	File.open('example.txt', 'w'){|f| f.write 'hello'}
  end

  def write_file_down
  	File.truncate 'example.txt', 0
  end

end
```

If you haven't noticed, the _down_ action should always perform the inverse of the operations in the _up_ action.

We can now transition to version 2 by execute `migrate` again. If we are not already in version 1, the first migration is run before the second. If we wish to return to version 1, we can do so by executing `migrate -v 1` or `migrave -v create_file`.



## Custom Runners

TODO

### Hooks

TODO