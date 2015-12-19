class AddAttachmentImageToMerchants < ActiveRecord::Migration
  def self.up
    change_table :merchants do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :merchants, :image
  end
end
