class ResourcesController < ApplicationController
  layout 'application'
  before_filter :authorize, only: [:edit, :update, :destroy, :new]

  def home
    @resource = Resource.new
    @resources = Resource.search(params[:search]) #.paginate(:per_page => 100, :page => params[:page])
    @resources.each do |resource|
      resource[:keywords_for_view] = resource.keywords_from_user && resource.keywords_from_source
    end
  end

  # GET /resources
  def index
    @resources = Resource.order("id desc")
  end

  # GET /resources/1
  def show
    @resource = Resource.find(params[:id])
  end

  # GET /resources/new
  def new
    @resource = Resource.new
  end

  # GET /resources/1/edit
  def edit
    @resource = Resource.find(params[:id])
  end

  def create
    if params[:url_or_title]
      @existing_resource = Resource.find_by_raw_url(params[:url_or_title])
    else
      @existing_resource = Resource.find_by_raw_url(params[:resource][:raw_url])
    end

    #if the resource already exists, redirect to it
    if @existing_resource
      flash[:notice] = 'Resource already existed.'
      redirect_to @existing_resource
      return
    end

    if params[:url_or_title]
      @resource = Resource.new({:user_id => params[:user_id], :raw_url => params[:url_or_title]})
    else
      @resource = Resource.new(params[:resources])
    end

    # try to scrape
    begin
      scrape_results = scrape_resource(@resource.raw_url)
      @resource.raw_html = scrape_results[:raw_html]
    rescue
      @resource.raw_html = FALSE
    end

    # if scraped
    if @resource.raw_html
      @resource.parse_scraped_data(scrape_results[:html])
    else
      @resource.title_from_source = @resource.raw_url
    end

    if @resource.save
      flash[:notice] = 'Resource was successfully created.'
      redirect_to resources_path
    else
      flash[:notice] = 'Resource not created.'
      render "resources/new"
    end
  end

  # PUT /resources/1
  def update
    @resource = Resource.find(params[:id])

    if @resource.update_attributes(params[:resource])
      redirect_to resources_path, notice: 'Resource was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /resources/1
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    redirect_to resources_url
  end

end
