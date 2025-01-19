import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  List<FocusNode> _imagesUrlFocus = [];
  List<TextEditingController> _imagesUrlController = [];

  int _visibleFields = 1;

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  @override
  void initState() {
    super.initState();

    // Inicializando os controladores das imagens
    _imagesUrlController = List.generate(3, (_) => TextEditingController());
    _imagesUrlController[0].addListener(() => _updateVisibility());

    _imagesUrlFocus = List.generate(3, (_) => FocusNode());
    for (var focus in _imagesUrlFocus) {
      focus.addListener(() => _updateImage());
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;

        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imagesUrl'] = product.imagesUrl;

        for (int i = 0; i < 3; i++) {
          _imagesUrlController[i].text = product.imagesUrl[i];
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();

    for (int i = 0; i < 3; i++) {
      _imagesUrlController[i].dispose();
      _imagesUrlFocus[i].dispose();
    }
  }

  void _updateImage() {
    setState(() {});
  }

  void _updateVisibility() {
    setState(() {
      _visibleFields = 3;
    });
  }

  bool _isImageUrlValid(String url) {
    bool isValid = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWith = url.toLowerCase().endsWith('png') ||
        url.toLowerCase().endsWith('jpg') ||
        url.toLowerCase().endsWith('jpeg');

    return isValid && endsWith;
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    // Salvando as urls
    List<String> images = [];
    for (var controller in _imagesUrlController) {
      images.add(controller.text);
    }
    _formData['imagesUrl'] = images;

    Provider.of<ProductList>(
      context,
      listen: false,
    ).saveProduct(_formData);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produto'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formData['name']?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                validator: (fieldText) {
                  final name = fieldText ?? '';

                  if (name.trim().isEmpty) {
                    return 'Forneça um nome para o produto';
                  }

                  if (name.trim().length < 3) {
                    return 'O nome do produto deve conter no mínimo 3 letras';
                  }

                  return null;
                },
                onSaved: (name) => _formData['name'] = name ?? '',
              ),
              TextFormField(
                initialValue: _formData['price']?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Preço',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                validator: (textField) {
                  final priceString = textField ?? '';
                  final price = double.tryParse(priceString) ?? -1;

                  if (price <= 0) {
                    return 'Informe um preço válido.';
                  }

                  return null;
                },
                onSaved: (price) => _formData['price'] = double.parse(price!),
              ),
              TextFormField(
                initialValue: _formData['description']?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                focusNode: _descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_imagesUrlFocus[0]);
                },
                validator: (fieldText) {
                  final description = fieldText ?? '';

                  if (description.trim().isEmpty) {
                    return 'Forneça um nome para o produto';
                  }

                  if (description.trim().length < 10) {
                    return 'A decrição deve conter no mínimo 10 letras';
                  }

                  return null;
                },
                onSaved: (description) =>
                    _formData['description'] = description ?? '',
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _visibleFields,
                itemBuilder: (ctx, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: index == 0
                                ? 'Url da imagem (Obrigatório)'
                                : 'Url da imagem (Opcional)',
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          textInputAction: index < 2
                              ? TextInputAction.next
                              : TextInputAction.done,
                          keyboardType: TextInputType.url,
                          focusNode: _imagesUrlFocus[index],
                          controller: _imagesUrlController[index],
                          onFieldSubmitted: (_) => (_) {
                            FocusScope.of(context)
                                .requestFocus(_imagesUrlFocus[index + 1]);
                          },
                          validator: (fieldText) {
                            final imageUrl = fieldText ?? '';

                            if (!_isImageUrlValid(imageUrl) &&
                                _imagesUrlController[0].text.isEmpty) {
                              return 'Insira uma Url válida';
                            }

                            return null;
                          },
                          onSaved: (imageUrl) =>
                              _formData['imageUrl'] = imageUrl ?? '',
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                          left: 10,
                        ),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: _imagesUrlController[index].text.isEmpty
                            ? const Text('Informe a Url')
                            : FittedBox(
                                child: Image.network(
                                  _imagesUrlController[index].text,
                                ),
                              ),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
