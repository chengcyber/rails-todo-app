class TodoItem < ActiveRecord::Base
  belongs_to :todo_list

  def new
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_items.new
  end
end
