class GigsController < ApplicationController
    def index
        @gigs = Gig.all
        render json: @gigs, include: :users, status: :ok
      end

      def show 
        @gig = Gig.find(params[:id])
        render json: @gig, include: :users, status: :ok
    end 


    def create
        @gig = Gig.new(gig_params)
        
        if @gig.save
          render json: @gig, status: :created
        else
          render json: { errors: @gig.errors }, status: :unprocessable_entity
        end
      end


      def update
        @gig = Gig.find(params[:id])        
        if @gig.update(gig_params)
          render json: @gig, status: :ok
        else
          render json: { errors: @gig.errors }, status: :unprocessable_entity
        end
      end


    def destroy
        @gig = Gig.find(params[:id])
       if @gig.destroy
        render json: { msg: 'success' }, status: :ok
        # head :no_content
       else 
        render json: { errors: @gig.errors }, status: :unprocessable_entity
       end 

      end

      private

      def gig_params 
        params.require(:gig).permit(:name, :date, :borough, :genre, :event_info, :tickets_url, :image_url, :user_id)
    end 
    end 