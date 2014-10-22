class Neuron
	attr :S, :M, :Weight, :learnClass
	
	def initialize
		@S = [1, 3, 2, 3, 5, 4, 5, 8, 7, 6]
		@M = [3, 3, 4, 2, 2, 5, 6, 4, 5, 3]
		@Weight = [rand(200) - 100, rand(200) - 100, rand(200) - 100]
		#@Weight = [1, -6 ,-5 ]
		@learnClass = [0, 0, 0, 0, 0, 1, 1, 1, 1, 1]
	end
	def classify (ss, mm)
		# if (@Weight[0]*ss + @Weight[1]*mm + @Weight[2]) > 0
		# 	return 1
		# elsif (@Weight[0]*ss + @Weight[1]*mm + @Weight[2]) < 0
		# 	return 0
		# else 
		# 	return -1
		# end
		return 1/(1 + Math::E ** (-@Weight[0]*ss - @Weight[1]*mm - @Weight[2]))
	end	
end

def checkReaction neuron
	i = 0
	while i < neuron.S.length
		curClass = neuron.classify(neuron.S[i], neuron.M[i])
		if (neuron.learnClass[i] != curClass.round) and (curClass != -1)
			return i
		elsif (curClass == -1)
			return -1
		end
		i = i+1
	end
	i
end

def teachNeuron (neuron, learnRate)
	iter = 0
	i = 0
	while true
		ws = neuron.Weight[0]
		wm = neuron.Weight[1]
		t = neuron.Weight[2]

		i = checkReaction neuron 
		if i == neuron.S.length
			puts 'checkReaction - Succses!'
			break
		elsif i == -1
			puts 'checkReaction - Error!'
			break
		end

		d = neuron.learnClass[i]
		y = neuron.classify(neuron.S[i], neuron.M[i]).to_f
		puts y.to_s

		neuron.Weight[0] = ws + learnRate.to_f * neuron.S[i] * (d - y)/((d - y).abs)
		neuron.Weight[1] = wm + learnRate.to_f * neuron.M[i] * (d - y)/((d - y).abs)
		neuron.Weight[2] = t + learnRate.to_f * (d - y)/((d - y).abs)

		if (neuron.Weight[0] == ws) and (neuron.Weight[1] == wm) and (neuron.Weight[2] == t)
			puts "Teaching finished!"
			break
		end
		iter = iter + 1
	end
	iter
end

def checkControlValue neuron
	puts '--- Control Value ---'
	puts '---------------------'
	puts '|  S |  m  |  class |'
	puts '---------------------'
	puts '|  ' + 1.to_s + ' |  ' + 5.to_s + '  |    ' + neuron.classify(1,5).round.to_s + '   |'
	puts '---------------------'	
	puts '|  ' + 3.to_s + ' |  ' + 6.to_s + '  |    ' + neuron.classify(3,6).round.to_s + '   |'
	puts '---------------------'	
	puts '|  ' + 5.to_s + ' |  ' + 7.to_s + '  |    ' + neuron.classify(5,7).round.to_s + '   |'
	puts '---------------------'	
end

def checkingNeuron neuron
	while true
		puts '--- Checking Neuron ---'
		puts 'Enter dS:'
		dS = gets
		puts 'Enter dm:'
		dm = gets
		puts 'Class: ' + neuron.classify(dS.to_i,dm.to_i).round.to_s
		puts 'Again? (0 - no, another - yes)'
		flag = gets.chomp
		if flag == 0.to_s
			break
		end
	end
end

		
puts 'Enter learning rate'
learnRate = gets.chomp
neuron = Neuron.new

puts 'Ws = ' + neuron.Weight[0].to_s
puts 'Wm = ' + neuron.Weight[1].to_s
puts 'T = ' + neuron.Weight[2].to_s
gets

iter = teachNeuron(neuron,learnRate)

puts 'Ws = ' + neuron.Weight[0].to_s
puts 'Wm = ' + neuron.Weight[1].to_s
puts 'T = ' + neuron.Weight[2].to_s
puts 'Iter: ' + iter.to_s
gets

checkControlValue neuron
checkingNeuron neuron