module API
  class QuestionsController < API::BaseController
    before_action :fetch_question, only: [:show]
    before_action :init_page_and_per_page, only: [:index]

    def index
      @questions = Question.published.includes(:asker, answers: [:answerer]).page(@page).per(@per_page)
    end

    def show; end

    private

    def fetch_question
      @question = Question.published.find(params[:id])
      @answers = @question.answers.includes(:answerer)
    end
  end
end
