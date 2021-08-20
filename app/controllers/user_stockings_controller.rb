class UserStockingsController < ApplicationController
        # before_action :set_user_stock, only: [:show, :edit, :update, :destroy,:create]
      
        # GET /user_stocks
        # GET /user_stocks.json
        # def index
        #   @user_stocks = UserStocking.all
        # end
      
        # # GET /user_stocks/1
        # # GET /user_stocks/1.json
        # def show
        # end
      
        # # GET /user_stocks/new
        # def new
        #   @user_stock = UserStocking.new
        # end
      
        # # GET /user_stocks/1/edit
        # def edit
        # end
      
        # POST /user_stocks
        # POST /user_stocks.json
        def create
          stock=Stock.check_db(params[:ticket])
          if stock.blank?
            stock = Stock.new_lookup(params[:ticket])
            stock.save
          end
            @user_stock = UserStocking.create(user: current_user, stock: stock)
            flash[:notice] = "Stock #{stock.name} was Successfully added to your portfolio"
            redirect_to my_portfolio_path
        end
          
          # @user_stock = UserStocking.create(user: current_user, stock: stock)
          # # if params[:stock_id].present?
          # #   @user_stock = UserStocking.new(stock_id: params[:stock_id], user: current_user)
          # # else
          # #   stock = Stock.find_by_ticket(params[:stock_ticket])
          # #   if stock
          # #     @user_stock = UserStocking.new(user: current_user, stock: stock)
          # #   else
          # #     stock = Stock.new_from_lookup(params[:stock_ticket])
          # #     if stock.save
          # #       @user_stock = UserStocking.new(user: current_user, stock: stock)
          # #     else
          # #       @user_stock = nil
          # #       flash[:error] = "Stock is not available"
          # #     end
          # #   end
          # end
          
      
          # respond_to do |format|
          #   if @user_stock.save
          #     format.html { redirect_to my_portfolio_path, 
          #       notice: "Stock #{@user_stock.stock.ticket} was successfully added" }
          #     format.json { render :show, status: :created, location: @user_stock }
          #   else
          #     format.html { render :new }
          #     format.json { render json: @user_stock.errors, status: :unprocessable_entity }
          #   end
          # end
      
      
        # PATCH/PUT /user_stocks/1
        # PATCH/PUT /user_stocks/1.json
        # def update
        #   respond_to do |format|
        #     if @user_stock.update(user_stock_params)
        #       format.html { redirect_to @user_stock, notice: 'User stock was successfully updated.' }
        #       format.json { render :show, status: :ok, location: @user_stock }
        #     else
        #       format.html { render :edit }
        #       format.json { render json: @user_stock.errors, status: :unprocessable_entity }
        #     end
        #   end
        # end
      
        # DELETE /user_stocks/1
        # DELETE /user_stocks/1.json
        # def destroy
        #   @user_stock.destroy
        #   respond_to do |format|
        #     format.html { redirect_to my_portfolio_path, notice: 'Stock was successfully removed from portfolio.' }
        #     format.json { head :no_content }
        #   end
        # end
        def destroy
          stock = Stock.find(params[:id])
          user_stock = UserStocking.where(user_id: current_user.id, stock_id: stock.id).first
          user_stock.destroy
          flash[:notice] = "#{stock.ticket} was successfully removed from portfolio"
          redirect_to my_portfolio_path
        end
        # private
          # Use callbacks to share common setup or constraints between actions.
          # def set_user_stock
          #   @user_stock = UserStocking.find(params[:id])
          # end
      
          # # Never trust parameters from the scary internet, only allow the white list through.
          # def user_stock_params
          #   params.require(:user_stock).permit(:user_id, :stock_id)
          # end
  
end