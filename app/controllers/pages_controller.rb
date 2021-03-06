class PagesController < ApplicationController
  respond_to :html, :xml, :json
  before_filter :authenticate_user!, :except => [:show]   
    
  # GET /pages
  # GET /pages.xml
  def index
    @pages = Page.all
    respond_with(@pages)
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find(params[:id])
    @columns = @page.columns.order("position ASC")
    @new_contact = Contact.new
    
    begin
      @bannerimg = Ckeditor::Picture.find(@page.ckeditor_asset_id)
    rescue
      @bg_css = "background:none;"
    else 
      @bannerheight = Paperclip::Geometry.from_file(@bannerimg).height
      @bannerimg_path = view_context.image_path(@bannerimg.url)
      @bg_css = "background-image:url(" + @bannerimg_path + "); background-position: bottom center; background-repeat: no-repeat; height:" + @bannerheight.to_s + "px;"
    end   
    
    render :layout => "pageshow"
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = Page.new
    respond_with(@page)
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])
    flash[:notice] = "Page successfully created" if @page.save
    respond_with(@page)
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find(params[:id])
    flash[:notice] = "Page successfully updated" if @page.update_attributes(params[:page])
    respond_with(@page)
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])
    flash[:notice] = "Page successfully deleted" if @page.destroy
    redirect_to pages_path
  end
end
