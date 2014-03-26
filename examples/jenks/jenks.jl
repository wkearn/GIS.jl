# Jenks Natural Breaks Classification by Shaun Walbridge
function jenks_matrix_init(data, n_classes)
  n_data = length(data)
  lower_class_limits  = zeros(n_data + 1, n_classes + 1)
  lower_class_limits[2,2:n_classes+1] = 1.0

  variance_combinations = zeros(n_data + 1, n_classes + 1)
  variance_combinations[3:n_data+1, 2:n_classes+1] = Inf 
  return lower_class_limits, variance_combinations
end

function jenks_matrices(data, n_classes)
  @inbounds begin
    lower_class_limits, variance_combinations = jenks_matrix_init(data, n_classes)
   
    for l in 2:length(data)
      sum = 0.0
      sum_squares = 0.0
      w = 0.0
      variance = 0.0
      for m in 1:l
        # 'III' originally
        lcl = l - m + 1
        val = data[lcl]

        w += 1
        sum += val
        sum_squares += val*val

        variance = sum_squares - (sum*sum) / w
        if lcl != 1
          for j in 2:n_classes
            var_plus_prev = variance + variance_combinations[lcl, j]
            if variance_combinations[l+1, j+1] >= var_plus_prev
              lower_class_limits[l+1, j+1] = lcl
              variance_combinations[l+1, j+1] = var_plus_prev
            end
          end
        end
      end
      lower_class_limits[l+1,2] = 1.0
      variance_combinations[l+1,2] = variance
    end
  end
  return lower_class_limits, variance_combinations
end

function jenks(data, n_classes)
  if n_classes > length(data)
    return
  end

  sort!(data)

  lower_class_limits, variance_combinations = jenks_matrices(data, n_classes)

  k = length(data)
  class = zeros(n_classes+1)
  count_num = n_classes

  class[n_classes+1] = data[k]
  class[1] = data[1]

  while count_num > 1
    elt = int(lower_class_limits[k,count_num+1] - 1)
    class[count_num] = data[elt]
    k = int(lower_class_limits[k,count_num+1])
    count_num -= 1
  end

  return class
end
