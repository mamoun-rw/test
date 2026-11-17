NAME = push_swap
BONUS_NAME = checker

CC = gcc
CFLAGS = -Wall -Wextra -Werror -I. -Ilibft -Ift_printf

LIBFT_DIR = libft
LIBFT = $(LIBFT_DIR)/libft.a

PRINTF_DIR = ft_printf
PRINTF = $(PRINTF_DIR)/libftprintf.a

OBJ_DIR = obj

COMMON_SRCS = utils.c \
	parser_utils.c \
	parser.c \
	stack_init.c \
	stack_utils.c \
	operations_swap.c \
	operations_push.c \
	operations_rotate.c \
	operations_reverse.c \
	op_exec.c \
	op_exec_rot.c \
	op_exec_rev.c \
	bench_record.c \
	bench.c \
	disorder.c \
	sort_small.c \
	strat_simple.c \
	strat_medium.c \
	strat_targets.c \
	strat_complex.c \
	strat_bounce.c

SRCS = push_swap.c $(COMMON_SRCS)
BONUS_SRCS = checker.c checker_utils.c $(COMMON_SRCS)

OBJS = $(addprefix $(OBJ_DIR)/,$(SRCS:.c=.o))
BONUS_OBJS = $(addprefix $(OBJ_DIR)/,$(BONUS_SRCS:.c=.o))

all: $(LIBFT) $(PRINTF) $(NAME)

$(LIBFT):
	@make -C $(LIBFT_DIR)

$(PRINTF):
	@make -C $(PRINTF_DIR)

$(NAME): $(OBJS) $(LIBFT) $(PRINTF)
	$(CC) $(CFLAGS) $(OBJS) $(LIBFT) $(PRINTF) -o $(NAME)

bonus: $(LIBFT) $(PRINTF) $(BONUS_NAME)

$(BONUS_NAME): $(BONUS_OBJS) $(LIBFT) $(PRINTF)
	$(CC) $(CFLAGS) $(BONUS_OBJS) $(LIBFT) $(PRINTF) -o $(BONUS_NAME)

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(OBJ_DIR)/%.o: %.c push_swap.h | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJ_DIR)
	@make -C $(LIBFT_DIR) clean
	@make -C $(PRINTF_DIR) clean

fclean: clean
	rm -f $(NAME) $(BONUS_NAME)
	@make -C $(LIBFT_DIR) fclean
	@make -C $(PRINTF_DIR) fclean

re: fclean all

.PHONY: all clean fclean re bonus