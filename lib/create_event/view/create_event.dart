import 'dart:developer';

import 'package:core_components/core_components.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ips_events_manager/create_event/cubit/events_create_cubit.dart';
import 'package:ips_events_manager/ips_events/cubit/event_category_cubit.dart';
import 'package:ips_events_manager/theme/theme.dart';
import 'package:ips_events_manager/widgets/widgets.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  late GlobalKey<FormBuilderState> formKey;
  late TextEditingController dateTimeController;
  late TextEditingController nameController;
  late TextEditingController speakerController;
  late TextEditingController vacanciesController;
  late TextEditingController descriptionController;
  late TextEditingController courseController;
  late TextEditingController unitController;
  late TextEditingController roomController;
  late TextEditingController meetingLinkController;
  late List<String> chosenCategories;
  late bool isOnline;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormBuilderState>();
    dateTimeController = TextEditingController();
    nameController = TextEditingController();
    speakerController = TextEditingController();
    vacanciesController = TextEditingController();
    descriptionController = TextEditingController();
    courseController = TextEditingController();
    unitController = TextEditingController();
    roomController = TextEditingController();
    meetingLinkController = TextEditingController();
    chosenCategories = [];
    isOnline = false;
  }

  @override
  void dispose() {
    dateTimeController.dispose();
    nameController.dispose();
    speakerController.dispose();
    dateTimeController.dispose();
    vacanciesController.dispose();
    descriptionController.dispose();
    courseController.dispose();
    unitController.dispose();
    roomController.dispose();
    meetingLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final firstDateToPick = currentDate.weekday == 6
        ? currentDate.add(const Duration(days: 2))
        : currentDate.weekday == 7
            ? currentDate.add(const Duration(days: 1))
            : currentDate;

    final categories =
        BlocProvider.of<EventCategoryCubit>(context).state.categories;

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
      body: BlocListener<EventsCreateCubit, EventsCreateState>(
        listener: (context, state) {
          if (state is EventsCreateLoadInProgress) {
            context.loaderOverlay.show();
          } else if (state is EventsCreateLoadSuccess) {
            context.loaderOverlay.hide();
            Navigator.pop(context);
          } else if (state is EventsCreateLoadError) {
            context.loaderOverlay.hide();
          }
        },
        child: SingleChildScrollView(
          child: EventsPadding(
            padding: EventsEdgeInsets.only(
              left: EventsSize.normal,
              right: EventsSize.normal,
              bottom: EventsSize.normal,
            ),
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
                            controller: nameController,
                            name: 'name',
                            decoration: const InputDecoration(
                              labelText: 'Nome do Evento',
                              icon: Icon(MdiIcons.formatLetterCase),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: 'Obrigatório',
                              ),
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
                            controller: speakerController,
                            name: 'speaker',
                            decoration: const InputDecoration(
                              labelText: 'Orador do Evento',
                              icon: Icon(MdiIcons.accountTieVoice),
                            ),
                            onChanged: (text) {},
                            // valueTransformer: (text) => num.tryParse(text),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: 'Obrigatório',
                              ),
                            ]),
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        EventsPadding(
                          padding:
                              EventsEdgeInsets.only(bottom: EventsSize.normal),
                          child: FormBuilderTextField(
                            controller: courseController,
                            name: 'targetCourse',
                            decoration: const InputDecoration(
                              labelText: 'Curso Alvo',
                              icon: Icon(MdiIcons.bookEducation),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: 'Obrigatório',
                              ),
                              FormBuilderValidators.minLength(
                                5,
                                errorText: 'Demasiado pequeno',
                              ),
                            ]),
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        EventsPadding(
                          padding:
                              EventsEdgeInsets.only(bottom: EventsSize.normal),
                          child: FormBuilderTextField(
                            controller: unitController,
                            name: 'targetUnit',
                            decoration: const InputDecoration(
                              labelText: 'Unidade Orgânica Alvo',
                              icon: Icon(MdiIcons.bookInformationVariant),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: 'Obrigatório',
                              ),
                              FormBuilderValidators.minLength(
                                5,
                                errorText: 'Demasiado pequeno',
                              ),
                            ]),
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        EventsPadding(
                          padding:
                              EventsEdgeInsets.only(bottom: EventsSize.normal),
                          child: Row(
                            children: [
                              Flexible(
                                child: FormBuilderCheckbox(
                                  name: 'isOnline',
                                  initialValue: false,
                                  activeColor: lightBlack,
                                  title: RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Online',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      isOnline = value ?? false;
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              if (isOnline)
                                Flexible(
                                  flex: 2,
                                  child: FormBuilderTextField(
                                    controller: meetingLinkController,
                                    name: 'meetingLink',
                                    decoration: const InputDecoration(
                                      labelText: 'Link da Reunião',
                                      icon: Icon(MdiIcons.microsoftTeams),
                                    ),
                                    validator: (value) {
                                      if (meetingLinkController.text.isEmpty) {
                                        return 'Obrigatório';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                  ),
                                )
                              else
                                Flexible(
                                  flex: 2,
                                  child: FormBuilderTextField(
                                    controller: vacanciesController,
                                    name: 'vacancies',
                                    decoration: const InputDecoration(
                                      labelText:
                                          'Vagas (ilimitadas por defeito)',
                                      labelStyle: TextStyle(fontSize: 12),
                                      icon: Icon(MdiIcons.accountSupervisor),
                                    ),
                                    keyboardType: TextInputType.number,
                                    valueTransformer: (text) =>
                                        int.tryParse(text!),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (!isOnline)
                          EventsPadding(
                            padding: EventsEdgeInsets.only(
                              bottom: EventsSize.normal,
                            ),
                            child: FormBuilderTextField(
                              controller: roomController,
                              name: 'room',
                              decoration: const InputDecoration(
                                labelText: 'Sala do Evento',
                                alignLabelWithHint: true,
                                icon: Icon(MdiIcons.bookAccount),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Obrigatório',
                                ),
                              ]),
                              keyboardType: TextInputType.name,
                            ),
                          ),
                        EventsPadding(
                          padding:
                              EventsEdgeInsets.only(bottom: EventsSize.normal),
                          child: FormBuilderFilterChip<String>(
                            name: 'choice_chip',
                            decoration: const InputDecoration(
                              labelText: 'Selecione uma Categoria',
                              icon: Icon(MdiIcons.lightbulbOn),
                            ),
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            spacing: 5,
                            runSpacing: 5,
                            selectedColor: lightBlack,
                            options:
                                List<FormBuilderChipOption<String>>.generate(
                                    categories.length, (i) {
                              final currentCategory = categories.elementAt(i);
                              return FormBuilderChipOption(
                                value: currentCategory.id,
                                child: Text(currentCategory.name),
                              );
                            }),
                            onChanged: (value) => setState(() {
                              chosenCategories = value ?? [];
                            }),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Pelo menos uma';
                              }
                              return null;
                            },
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
                            initialDate: firstDateToPick,
                            firstDate: firstDateToPick,
                            lastDate:
                                firstDateToPick.add(const Duration(days: 30)),
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
                            onChanged: print,
                            validator: (val) {
                              try {
                                DateTime.parse(val!);
                                return null;
                              } catch (e) {
                                log(e.toString());
                                return 'Obrigatório';
                              }
                            },
                            onSaved: print,
                          ),
                        ),
                        FormBuilderTextField(
                          controller: descriptionController,
                          name: 'description',
                          decoration: const InputDecoration(
                            labelText: 'Descrição do Evento',
                            alignLabelWithHint: true,
                          ),
                          maxLines: 6,
                          maxLength: 200,
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
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          IpsEventsAnalytics.recordAnalytic(
                            eventName: 'event_create_button_pressed',
                          );

                          BlocProvider.of<EventsCreateCubit>(context)
                              .createEvent(
                            title: nameController.text,
                            speaker: speakerController.text,
                            startDate: DateTime.parse(dateTimeController.text),
                            description: descriptionController.text,
                            categoryIds: chosenCategories,
                            room: roomController.text,
                            targetCourse: courseController.text,
                            targetUnit: unitController.text,
                            meetingLink: meetingLinkController.text,
                            isOnline: isOnline,
                          );
                        }
                      },
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
