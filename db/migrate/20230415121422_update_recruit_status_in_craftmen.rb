class UpdateRecruitStatusInCraftmen < ActiveRecord::Migration[6.1]
  def up
    # NULL値を適切なデフォルト値に置き換えます。ここでは、0を使用していますが、適切なデフォルト値に応じて変更してください。
    Craftman.where(recruit_status: nil).update_all(recruit_status: 0)

    # null: false制約を追加
    change_column_null :craftmen, :recruit_status, false
  end

  def down
    # 制約を元に戻す場合は、null: false制約を削除
    change_column_null :craftmen, :recruit_status, true
  end
end
