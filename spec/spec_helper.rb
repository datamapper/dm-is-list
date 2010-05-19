require 'dm-core/spec/setup'
require 'dm-core/spec/lib/adapter_helpers'

require 'dm-is-list'
require 'dm-migrations'

DataMapper::Spec.setup

class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String

  has n, :todos
end

class Todo
  include DataMapper::Resource

  property :id,    Serial
  property :title, String

  belongs_to :user

  is :list, :scope => [:user_id]
end

module TodoListHelper
  ##
  # Keep things DRY shortcut
  #
  #   todo_list.should == [ [1, 1], [2, 2], [3, 3], [4, 4], [5, 5] ]
  #
  #   todo_list(:user => @u2, :order => [:id]).should == [ [1, 1], [2, 2], [3, 3], [4, 4], [5, 5] ]
  #
  def todo_list(options={})
    options = { :user => @u1, :order => [:position] }.merge(options)
    Todo.all(:user => options[:user], :order => options[:order]).map{ |a| [a.id, a.position] }
  end
end

Spec::Runner.configure do |config|
  config.extend(DataMapper::Spec::Adapters::Helpers)
  config.send(:include, TodoListHelper)
end
