class CommentSerializer < ActiveModel::Serializer
  attributes :id, :article_id, :comment_content
end
