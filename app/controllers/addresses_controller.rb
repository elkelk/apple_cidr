class AddressesController < ApplicationController
  before_action :set_address

  def index
    @addresses = Address.all
  end

  def new
    @address = Address.new
  end

  def show
    redirect_to edit_address_path(@address)
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to addresses_path, notice: 'Address was successfully created.'
    else
      flash[:error] = @address.errors.to_a.join
      render action: 'new'
    end
  end

  def update
    if @address.update(address_params)
      redirect_to addresses_path, notice: 'Address was successfully updated.'
    else
      flash[:error] = @address.errors.to_a.join
      render action: 'edit'
    end
  end

  def destroy
    @address.destroy
    redirect_to addresses_path, notice: 'Address was deleted.'
  end

  def whitelisted
    render json: { whitelisted: Address.whitelisted?(params[:ip_address]) }
  end

  private

  def set_address
    @address = params[:id] && Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:cidr)
  end
end
