require 'rails_helper'

module Api
  RSpec.describe Api::PostsController, type: :controller do
    subject { JSON.parse(response.body) }

    describe "GET posts#index" do
      let!(:posts) { create_list(:post,2) }
      before (:each) do
        get :index
      end

      it "returns a 200 status" do
        expect(response.status).to eq 200
      end

      it "returns an array of posts" do
        expect(subject.length).to eq posts.length
      end
    end

    describe "POST posts#index" do
      let(:post_params) do
        attributes_for(:post)
      end

      def create_request
        post :create, params: { 'post' => post_params }
      end

      it "returns 200 status" do
        expect { create_request }.to change(Post, :count).by 1
      end

      it "responds with a newly created object" do
        create_request
        expect(subject['title']).to eq(post_params[:title])
        expect(subject['body']).to eq(post_params[:body])
        expect(subject['username']).to eq(post_params[:username])
      end

      it "responds with status code 201" do
        create_request
        expect(response.status).to eq 201
      end

      it "responds with a newly created object" do
        create_request
        expect(response.content_type).to eq 'application/json'
      end
    end

    describe "GET posts#show" do
      let!(:post) { create :post }
      before (:each) do
        get :show, params: { id: post.id }
      end

      it "returns a 200 status" do
        expect(response.status).to eq 200
      end

      it "responds with json format" do
        expect(response.content_type).to eq 'application/json'
      end

      it "responds with requested object" do
        expect(subject['title']).to eq(post[:title])
        expect(subject['body']).to eq(post[:body])
        expect(subject['username']).to eq(post[:username])
      end
    end

    describe "PUT posts#update" do
      let!(:post) { create :post }
      let(:title) { "Third post" }
      before (:each) do
      put :update, params: { id: post.id, post: { title: title } }
      end

      it "returns a 200 status" do
        expect(response.status).to eq 200
      end

      it "responds with json format" do
        expect(response.content_type).to eq 'application/json'
      end

      it "responds with updated object" do
        expect(subject['title']).to eq(title)
      end
    end

    describe "DELETE posts#destroy" do
      let!(:post) { create :post }

      def destroy_request
        delete :destroy, params: { id: post.id }
      end

      it "returns a 204 status" do
        destroy_request
        expect(response.status).to eq 204
      end
      it "returns a 204 status" do
        expect { destroy_request }.to change(Post, :count).by -1
      end
    end
  end
end
