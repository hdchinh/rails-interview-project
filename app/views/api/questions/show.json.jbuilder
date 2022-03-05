json.set! :data do
  json.question do
    json.call(@question, :id, :title)

    json.asker do
      json.call(@question.asker, :id, :name)
    end

    json.answers @answers do |answer|
      json.call(answer, :id, :body)

      json.answerer do
        json.call(answer.answerer, :id, :name)
      end
    end
  end
end
