class GroupLabelsController < ApplicationController
  # GET /group_labels
  # GET /group_labels.json
  def index
    @group_labels = GroupLabel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @group_labels }
    end
  end

  # GET /group_labels/1
  # GET /group_labels/1.json
  def show
    @group_label = GroupLabel.find(params[:id])
    @labels = @group_label.labels
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group_label }
      format.pdf do
        pdf = GroupLabelPdf.new(@labels)
        send_data pdf.render, filename: "group_#{@group_label.id}.pdf",
          type: "application/pdf",
          disposition: "inline"
      end
    end
  end

  # GET /group_labels/new
  # GET /group_labels/new.json
  def new
    @group_label = GroupLabel.new
    1.times {@group_label.labels.build}
  
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group_label }
    end
  end

  # GET /group_labels/1/edit
  def edit
    @group_label = GroupLabel.find(params[:id])
  end

  # POST /group_labels
  # POST /group_labels.json
  def create
    @group_label = GroupLabel.new(params[:group_label])

    respond_to do |format|
      if @group_label.save
        format.html { redirect_to @group_label, notice: 'Group label was successfully created.' }
        format.json { render json: @group_label, status: :created, location: @group_label }
      else
        format.html { render action: "new" }
        format.json { render json: @group_label.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /group_labels/1
  # PUT /group_labels/1.json
  def update
    @group_label = GroupLabel.find(params[:id])

    respond_to do |format|
      if @group_label.update_attributes(params[:group_label])
        format.html { redirect_to @group_label, notice: 'Group label was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group_label.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_labels/1
  # DELETE /group_labels/1.json
  def destroy
    @group_label = GroupLabel.find(params[:id])
    @group_label.destroy

    respond_to do |format|
      format.html { redirect_to group_labels_url }
      format.json { head :no_content }
    end
  end
end
