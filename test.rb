require 'natto'

text10 = '豚スネ肉'
ary10=[]

natto = Natto::MeCab.new
natto.parse(text10) do |n|
  ary10 << n.surface unless n.surface.empty? # 空白が混じるため除外する
end
e = ary10.join(",")
p e


text11 = 'ねぎ'
ary11=[]

natto = Natto::MeCab.new
natto.parse(text11) do |n|
  ary11 << n.surface unless n.surface.empty? # 空白が混じるため除外する
end
f = ary11.join(",")
p f


text12 = 'トマト'
ary12=[]

natto = Natto::MeCab.new
natto.parse(text12) do |n|
  ary12 << n.surface unless n.surface.empty? # 空白が混じるため除外する
end
g =  ary12.join(",")
p g

ary0 = []
ary0 << e.split(',')
ary0 << f.split(',')
ary0 << g.split(',')
p ary0.flatten

# ---------------------
text1 = '牛スネ肉'
ary1=[]

natto = Natto::MeCab.new
natto.parse(text1) do |n|
  ary1 << n.surface unless n.surface.empty? # 空白が混じるため除外する
end
a = ary1.join(",")
p a


text2 = '玉ねぎ'
ary2=[]

natto = Natto::MeCab.new
natto.parse(text2) do |n|
  ary2 << n.surface unless n.surface.empty? # 空白が混じるため除外する
end
b = ary2.join(",")
p b


text3 = 'にんじん'
ary3=[]

natto = Natto::MeCab.new
natto.parse(text3) do |n|
  ary3 << n.surface unless n.surface.empty? # 空白が混じるため除外する
end
c =  ary3.join(",")
p c

aryz = []
aryz << a.split(',')
aryz << b.split(',')
aryz << c.split(',')
p aryz.flatten

p ((ary0.flatten & aryz.flatten).length.to_f/(ary0.flatten | aryz.flatten).length).round(3)