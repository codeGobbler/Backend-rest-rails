# frozen_string_literal: true

module Api
  module V1
    class FactsController < ApplicationController
      def index
        @user = User.find(params[:user_id])
        render json: @user.facts # NOTE: that because the facts route is nested inside users
        # we return only the facts belonging to that user
      end

      # GET /users/:user_id/facts/:id
      def show
        # your code goes here
      end

      # POST /users/:user_id/facts
      def create
        @user = User.find(params[:user_id])
        @fact = @user.facts.new(fact_params)
        if @fact.save
          render json: @fact, status: 201
        else
          render json: { error: "The fact entry could not be created. #{@fact.errors.full_messages.to_sentence}" },
                 status: 400
        end
      end

      # PUT /users/:user_id/facts/:id
      def update
        # your code goes here
      end

      # DELETE /users/:user_id/facts/:id
      def destroy
        # your code goes here
      end

      private

      def fact_params
        params.require(:fact).permit(:fact_text, :likes)
      end

      def set_fact
        @fact = Fact.find(params[:id])
      end
    end
  end
end
