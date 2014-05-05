class ContactsController < ApplicationController

  def index
    @contacts = Contact.all

    respond_to do |format|
      format.html
      format.json { render :json => @contacts }
    end
  end


  def new
    @contact = Contact.new
  end


  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      respond_to do |format|
        format.html do
          flash[:notice] = "Contact created."
          redirect_to contacts_path
        end
        format.json { render :json => @contact, :status => 201 }
      end
    else
      respond_to do |format|
        format.html { render 'new' }
        format.json { render :json => @contact.errors, :status => 422 }
      end
    end
  end


  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @contact }
    end
  end


  def edit
    @contact = Contact.find(params[:id])
  end


  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      respond_to do |format|
        format.html do
          flash[:notice] = "Contact updated."
          redirect_to contact_path(@contact)
        end
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { render 'edit' }
        format.json { render :json => @contact.errors, :status => 422 }
      end
    end
  end


  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html do
        flash[:notice] = "Contact deleted."
        redirect_to contacts_path
      end
      format.json { head :no_content }
    end
  end


private

  def contact_params
    params.require(:contact).permit(:name, :email)
  end

end

