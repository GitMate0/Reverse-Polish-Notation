def numeric?(s)
	true if Float(s) rescue false
end

def show_stack(out, stack)
	puts out.to_s
	puts stack.to_s
	print "\n"
end

priority = {"(" => 0, ")" => 0, "^" => 1, "*" => 2, "/" => 2, "+" => 3, "-" => 3}

out = []
stack = []

print "Enter mathematical expression: "
matmod = gets.chomp.tr(" ", "").chars
buffer = ""

matmod.each_with_index do |sym, indx|
	if sym.match("[0-9a-zA-Z\.]{1}")
		buffer += sym

	elsif sym == "-" and stack.empty? or matmod[indx-1] == "("
		buffer += sym

	elsif "()^*/+-".include?(sym)
		case sym
		when "("
			stack << buffer
			stack << sym
		when ")"
			out << buffer
			while stack.last != "("
				out << stack.pop
			end
			stack.pop
		else
			out << buffer
			if stack.last != "(" and !stack.empty?
				if priority[stack.last] <= priority[sym]
					out << stack.pop
				end
			end
			stack << sym
		end
		buffer = ""
	end
end

if buffer != ""
	out << buffer
end

while stack.length != 0
	out << stack.pop
end

out.concat(stack)
puts "Reverse polish notation: #{out.join(" ")}"