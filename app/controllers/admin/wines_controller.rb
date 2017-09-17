class Admin::WinesController < Admin::BaseController
  def index
    @wines = Wine.order('name').paginate(:page => params[:page], :per_page => 30)
  end

  def destroy
    Wine.find(params[:id]).destroy
    redirect_to admin_wines_path
  end
end
