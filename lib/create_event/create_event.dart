import 'package:core_components/core_components.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ips_events_manager/theme/theme.dart';
import 'package:ips_events_manager/widgets/widgets.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  late GlobalKey<FormBuilderState> formKey;
  late TextEditingController dateTimeController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormBuilderState>();
    dateTimeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Criar Evento',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            MdiIcons.arrowLeft,
            color: lightBlack,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: EventsPadding(
          padding: EventsEdgeInsets.all(EventsSize.normal),
          child: Column(
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: darkBlack, // <-- SEE HERE
                    onSurface: lightBlack, // <-- SEE HERE
                  ),
                ),
                child: FormBuilder(
                  key: formKey,
                  child: Column(
                    children: [
                      EventsPadding(
                        padding:
                            EventsEdgeInsets.only(bottom: EventsSize.normal),
                        child: FormBuilderTextField(
                          name: 'name',
                          decoration: const InputDecoration(
                            labelText: 'Nome do Evento',
                            icon: Icon(MdiIcons.formatLetterCase),
                          ),
                          onChanged: (text) {},
                          // valueTransformer: (text) => num.tryParse(text),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'context',
                            ),
                            FormBuilderValidators.numeric(errorText: 'context'),
                            FormBuilderValidators.max(
                              70,
                              errorText: 'errorText',
                            ),
                          ]),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      EventsPadding(
                        padding:
                            EventsEdgeInsets.only(bottom: EventsSize.normal),
                        child: FormBuilderTextField(
                          name: 'speaker',
                          decoration: const InputDecoration(
                            labelText: 'Orador do Evento',
                            icon: Icon(MdiIcons.accountTieVoice),
                          ),
                          onChanged: (text) {},
                          // valueTransformer: (text) => num.tryParse(text),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'context',
                            ),
                          ]),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      EventsPadding(
                        padding:
                            EventsEdgeInsets.only(bottom: EventsSize.normal),
                        child: FormBuilderTextField(
                          name: 'vacancies',
                          decoration: const InputDecoration(
                            labelText: 'Vagas do Evento',
                            icon: Icon(MdiIcons.accountSupervisor),
                          ),
                          onChanged: (number) {},
                          // valueTransformer: (text) => num.tryParse(text),
                          validator: FormBuilderValidators.compose([]),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      EventsPadding(
                        padding:
                            EventsEdgeInsets.only(bottom: EventsSize.normal),
                        child: FormBuilderChoiceChip<String>(
                          name: 'choice_chip',
                          decoration: const InputDecoration(
                            labelText: 'Selecione uma Categoria',
                            icon: Icon(MdiIcons.lightbulbOn),
                          ),
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          spacing: 5,
                          runSpacing: 5,
                          selectedColor: lightBlack,
                          options: const [
                            FormBuilderChipOption(
                              value: 'Test',
                              child: Text('Test'),
                            ),
                            FormBuilderChipOption(
                              value: 'Test 1',
                              child: Text('Test 1'),
                            ),
                            FormBuilderChipOption(
                              value: 'Test 2',
                              child: Text('Test 2'),
                            ),
                            FormBuilderChipOption(
                              value: 'Test 3',
                              child: Text('Test 3'),
                            ),
                            FormBuilderChipOption(
                              value: 'Test 4',
                              child: Text('Test 4'),
                            ),
                          ],
                        ),
                      ),
                      EventsPadding(
                        padding:
                            EventsEdgeInsets.only(bottom: EventsSize.normal),
                        child: DateTimePicker(
                          controller: dateTimeController,
                          type: DateTimePickerType.dateTimeSeparate,
                          cursorColor: darkBlack,
                          dateMask: 'd MMM, yyyy',
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 30)),
                          icon: Icon(
                            MdiIcons.calendar,
                            color: darkBlack,
                          ),
                          enableInteractiveSelection: false,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          dateLabelText: t(LocaleKeys.date),
                          timeLabelText: t(LocaleKeys.hour),
                          selectableDayPredicate: (date) {
                            // Disable weekend days to select from the calendar
                            if (date.weekday == 6 || date.weekday == 7) {
                              return false;
                            }

                            return true;
                          },
                          errorInvalidText: 'Preencha a data e a hora.',
                          onChanged: print,
                          validator: (val) {
                            try {
                              DateTime.parse(val!);
                              return null;
                            } catch (e) {
                              return 'Preencha a data e hora';
                            }
                          },
                          onSaved: print,
                        ),
                      ),
                      FormBuilderTextField(
                        name: 'description',
                        decoration: const InputDecoration(
                          labelText: 'Descrição do Evento',
                          alignLabelWithHint: true,
                        ),
                        maxLines: 6,
                        maxLength: 200,
                        onChanged: (text) {},
                        // valueTransformer: (text) => num.tryParse(text),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Descrição necessária',
                          ),
                          FormBuilderValidators.minLength(
                            10,
                            errorText: 'No mínimo 10 caracteres',
                          ),
                        ]),
                        keyboardType: TextInputType.name,
                      ),
                    ],
                  ),
                ),
              ),
              EventsPadding(
                padding: EventsEdgeInsets.only(top: EventsSize.normal),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () => formKey.currentState!.validate(),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(lightBlack),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(MdiIcons.creation),
                        const SizedBox(
                          width: 10,
                        ),
                        IpsEventsText.lightTitle('Criar')
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
