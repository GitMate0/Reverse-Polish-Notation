def numeric?(s)
	true if Float(s) rescue false
end

priority = {"(" => 0, ")" => 0, "^" => 1, "*" => 2, "/" => 2, "+" => 3, "-" => 3}

out = []
stack = []

print "Enter mathematical expression: "
matmod = gets.chomp.tr(" ", "")

matmod.each do |sym|
	#puts out.to_s
	#puts stack.to_s
	if numeric?(sym) or sym.match("[a-zA-Z]{1}")
		out << sym
	elsif "()^*/+-".include?(sym)
		case sym
		when "("
			stack << sym
		when ")"
			while stack.last != "("
				out << stack.pop
			end
			stack.pop
		else
			if stack.last != "(" and stack.length != 0
				if priority[stack.last] <= priority[sym]
					out << stack.pop
				end
			end
			stack << sym
		end
	end
end
while stack.length != 0
	out << stack.pop
end

out.concat(stack)
puts "Reverse polish notation: #{out.join(" ")}"