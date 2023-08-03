class ChangePrefectureToBeNotNullInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :prefecture, false
  end
end
