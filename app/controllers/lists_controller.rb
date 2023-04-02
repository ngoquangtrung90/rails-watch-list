class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @list = List.find(params[:id])
    @movies_list = []
    @bookmarks = Bookmark.all
    @hash = {}
    @bookmarks.each do |bookmark|
      if bookmark.list_id == @list.id
        @movies_list << Movie.find(bookmark.movie_id)
        @hash[bookmark.movie_id.to_s] = bookmark
      end
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
