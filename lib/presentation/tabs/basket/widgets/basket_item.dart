import 'package:flutter/material.dart';
import '../../../../data/db/catched_todos.dart';

class BasketItem extends StatelessWidget {
  const BasketItem(
      {Key? key,
        required this.onUpdateTapped,
        required this.onDeleteTapped,
        required this.cachedTodo})
      : super(key: key);

  final VoidCallback onUpdateTapped;
  final VoidCallback onDeleteTapped;
  final CachedTodo cachedTodo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 5,
              offset: const Offset(1, 3),
              blurRadius: 5,
              color: Colors.grey.shade300,
            )
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cachedTodo.todoTitle,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
              ),
              const Expanded(child: SizedBox()),
              ...List.generate(
                cachedTodo.urgentLevel,
                    (index) => const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
              ),
              ...List.generate(
                5 - cachedTodo.urgentLevel,
                    (index) => const Icon(
                  Icons.star,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Description:"),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  cachedTodo.todoDescription,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: onUpdateTapped,
                child: Expanded(
                  child: Row(
                    children: const [
                      Icon(
                        Icons.edit,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Update")
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: onDeleteTapped,
                child: Expanded(
                  child: Row(
                    children: const [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Delete")
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}