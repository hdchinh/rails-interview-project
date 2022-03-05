json.total @questions.size
json.page @page
json.per_page @per_page
json.set! :data do
  json.array! @questions do |question|
    json.call(question, :id, :title)

    json.asker do
      json.call(question.asker, :id, :name)
    end

    json.answers question.answers do |answer|
      json.call(answer, :id, :body)

      json.answerer do
        json.call(answer.answerer, :id, :name)
      end
    end
  end
end
