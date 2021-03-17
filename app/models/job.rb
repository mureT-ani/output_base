class Job < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '学生' },
    { id: 3, name: '研究職' },
    { id: 4, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :users
end
