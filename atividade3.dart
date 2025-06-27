
import 'package:flutter/material.dart';

class Exercicio3 extends StatelessWidget {
  const Exercicio3({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Exercicio 3'),
        backgroundColor: colorScheme.inversePrimary


      ),

      body: Padding(padding: EdgeInsets.all(20),
       child: Center(
         child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
         
          ElevatedButton(onPressed: (){},
           child: Text('Botão 1')),
         
           TextButton(onPressed: (){}, 
           
           child: Text('Botão 2')),

           OutlinedButton(onPressed: (){},
            child: Text('Botão 3'))
         
         
         ],
         
          
         
         ),
       ),
      ),


      

    );
  }
}
