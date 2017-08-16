class AddAttachmentImageToPictures < ActiveRecord::Migration
  def change
    change_table :pictures do |t|

      reversible do |direction|
        direction.up { t.remove :url }
        direction.down { t.string :url }
      end

      t.attachment :image

    end
  end
end
