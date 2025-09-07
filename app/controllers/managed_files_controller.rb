class ManagedFilesController < ApplicationController
  def index
    scope = ManagedFile.includes(:themes)
    scope = filter_by_name(scope, params[:query])
    scope = filter_by_file_type(scope, params[:file_type])
    scope = filter_by_theme(scope, params[:theme_id])
    scope = filter_by_favorites(scope, params[:favorites])
    @managed_files = scope.order(created_at: :asc)
  end

  def show
    @managed_file = ManagedFile.find(params[:id])
    @themes = Theme.all 
  end

  def update
    @managed_file = ManagedFile.find(params[:id])
    if @managed_file.update(managed_file_params)
      redirect_to root_path, notice: "Archivo actualizado con éxito."
    else
      render :show
    end
  end

  def content
    managed_file = ManagedFile.find(params[:id])
    send_file managed_file.path, disposition: "inline"
  end

  private

  def managed_file_params
    params.require(:managed_file).permit(:notes, :favorite, theme_ids: [])
  end

  def filter_by_name(scope, query)
    return scope unless query.present?
    scope.where("managed_files.name ILIKE ?", "%#{query}%")
  end

  def filter_by_file_type(scope, file_type)
    return scope unless file_type.present?
    scope.where(file_type: file_type)
  end

  def filter_by_theme(scope, theme_id)
    return scope unless theme_id.present?
    scope.joins(:themes).where(themes: { id: theme_id })
  end

  def filter_by_favorites(scope, favorites_param)
    return scope unless favorites_param.present?
    scope.where(favorite: true)
  end
end