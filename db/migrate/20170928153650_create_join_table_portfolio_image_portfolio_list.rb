class CreateJoinTablePortfolioImagePortfolioList < ActiveRecord::Migration[5.0]
  def change
    create_join_table :portfolio_images, :portfolio_lists do |t|
      t.index [:portfolio_image_id, :portfolio_list_id], name: 'index_prt_imgs_lsts_on_prt_img_id_and_prt_lst_id'
      t.index [:portfolio_list_id, :portfolio_image_id], name: 'index_prt_imgs_lsts_on_prt_lst_id_and_prt_img_id'
    end
  end
end
