# frozen_string_literal: true

module Api
  module V1
    class FactsController < ApplicationController
      before_action :set_fact, only: %i[show update destroy]

      def index
        @user = User.find(params[:user_id])
        render json: @user.facts # NOTE: that because the facts route is nested inside users
        # we return only the facts belonging to that user
      end

      # GET /users/:user_id/facts/:id
      def show
        @user = User.find(params[:user_id])
        if @user.facts
          render json: @user.facts.find(params[:id])
        else
          render json: { error: "User error: #{@user.errors.full_messages.to_sentence}" }
        end
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
        if @fact.update(fact_params)
          render json: { message: 'Fact updated' }, status: 202
        else
          render json: { error: "Fact not updated: #{@fact.errors.full_messages.to_sentence}" }, status: 400
        end
      end

      # DELETE /users/:user_id/facts/:id
      def destroy
        @fact.destroy
        if @fact.destroy
          render json: { message: 'Fact successfully deleted' }, status: 200
        else
          render json: { error: "Fact cannot be deleted: #{@fact.errors.full_messages.to_sentence}" }, status: 400
        end
      end

      private

      def fact_params
        params.require(:fact).permit(:fact_text, :likes, :user_id)
      end

      def set_fact
        @fact = Fact.find(params[:id])
      end

      def set_user
        @user = Fact.user_id.find(params[:id])
      end
    end
  end
end
