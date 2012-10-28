class ResourcesController < ApplicationController
  before_filter :authorize, only: [:edit, :update, :destroy]

  # GET /resources
  # GET /resources.json
  def index
    @resources = Resource.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @resources }
    end
  end

  # GET /resources/1
  # GET /resources/1.json
  def show
    @resource = Resource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resource }
    end
  end

  # GET /resources/new
  # GET /resources/new.json
  def new
    @resource = Resource.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resource }
    end
  end

  # GET /resources/1/edit
  def edit
    @resource = Resource.find(params[:id])
  end

  def create
    p 'running ResourcesController#create'
    @resource = Resource.new(params[:resource])

    # try to scrape
    resource_object = Resource.scrape_data(@resource.raw_url)
    # add scraped data or nil
    @resource.keywords_from_source = resource_object[:keywords_from_source] ? resource_object[:keywords_from_source] : nil
    @resource.description_from_source = resource_object[:description_from_source] ? resource_object[:description_from_source] : nil
    @resource.title_from_source = resource_object[:title_from_source] ? resource_object[:title_from_source] : nil
    @resource.raw_html = resource_object[:raw_html] ? resource_object[:raw_html] : nil

    if @resource.save
      redirect_to resources_path, notice: 'Resource was successfully created.'
    else
      render action: "new"
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
  # DELETE /resources/1.json
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to resources_url }
      format.json { head :no_content }
    end
  end
end
