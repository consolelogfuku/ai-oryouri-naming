FactoryBot.define do
  require 'tiny_segmenter' 

  factory :ingredient do
    name {nil}
    # 形態素解析
    ts = TinySegmenter.new
    # build(:ingredient, name: '◯◯')とした場合(dishの関連として生成しなかった場合)、形態素解析できるようコードを書いておく
    morphemes {ts.segment(name).join(',')}
  end
end
