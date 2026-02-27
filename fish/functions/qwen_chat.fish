function qwen_chat
    # Set default values
    set -l default_model "mlx-community/Qwen2.5-Coder-14B-Instruct-4bit"
    set -l model $default_model
    set -l max_tokens 2048
    set -l temperature 0.7  # Default temperature added here
    
    # Handle model selection via the first argument
    if test (count $argv) -gt 0
        switch $argv[1]
            case 30b
                set model lmstudio-community/Qwen3-Coder-30B-A3B-Instruct-MLX-4bit
            case 14b
                set model "mlx-community/Qwen2.5-Coder-14B-Instruct-4bit"
            case "*"
                set model $argv[1]
        end
    end
    
    # Handle max_tokens override via the second argument (if provided)
    if test (count $argv) -gt 1
        # Note: When checking arguments past the first, make sure you don't overwrite
                           # a potential third argument if you only check count > 1.
                           # Assuming the user provides args sequentially for simplicity:
                           set max_tokens $argv[2]
                   end
    
                   # Handle temperature override via the third argument (optional)
                   if test (count $argv) -gt 2
                           set temperature $argv[3]
                   end
    
                   # Execute the mlx_lm chat command with all parameters
                   python3 -m mlx_lm chat \
                           --model $model \
                           --max-tokens $max_tokens \
                           --temp $temperature
               
end
