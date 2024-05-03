import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genius_assesment/core/error/failures.dart';
import 'package:genius_assesment/features/search/domain/entities/photos.dart';
import 'package:genius_assesment/features/search/domain/usecases/get_photo_usecase.dart';
import 'package:genius_assesment/features/search/data/models/filter_params_model.dart';
import 'package:genius_assesment/features/search/domain/entities/pagination_meta_data.dart';
part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final GetPhotoUseCase _getPhotoUseCase;

  PhotoBloc(this._getPhotoUseCase)
      : super(PhotoInitial(
            photos: const [],
            params: const FilterPhotoParams(),
            metaData: PaginationMetaData(
              totalHits: 0,
              total: 0,
            ))) {
    on<GetPhotos>(_onLoadPhotos);
    on<GetMorePhotos>(_onLoadMorePhotos);
  }

  void _onLoadPhotos(GetPhotos event, Emitter<PhotoState> emit) async {
    try {
      emit(PhotoLoading(
        photos: const [],
        metaData: state.metaData,
        params: event.params,
      ));
      final result = await _getPhotoUseCase(event.params);
      result.fold(
        (failure) => emit(PhotoError(
          photos: state.photos,
          metaData: state.metaData,
          failure: failure,
          params: event.params,
        )),
        (photoResponse) => emit(PhotoLoaded(
          metaData: photoResponse.paginationMetaData,
          photos: photoResponse.photos,
          params: event.params,
        )),
      );
    } catch (e) {
      emit(PhotoError(
        photos: state.photos,
        metaData: state.metaData,
        failure: ExceptionFailure(),
        params: event.params,
      ));
    }
  }

  void _onLoadMorePhotos(GetMorePhotos event, Emitter<PhotoState> emit) async {
    var state = this.state;
    var limit = 20;
    var total = state.metaData.total;
    var loadedPhotosLength = state.photos.length;
    // check state and loaded photos amount[loadedPhotosLength] compare with
    // number of results total[total] results available in server
    if (state is PhotoLoaded && (loadedPhotosLength < total)) {
      try {
        emit(PhotoLoading(
          photos: state.photos,
          metaData: state.metaData,
          params: state.params,
        ));
        final result =
            await _getPhotoUseCase(FilterPhotoParams(limit: limit + 10));
        result.fold(
          (failure) => emit(PhotoError(
            photos: state.photos,
            metaData: state.metaData,
            failure: failure,
            params: state.params,
          )),
          (photoResponse) {
            List<Photos> photos = state.photos;
            photos.addAll(photoResponse.photos);
            emit(PhotoLoaded(
              metaData: state.metaData,
              photos: photos,
              params: state.params,
            ));
          },
        );
      } catch (e) {
        emit(PhotoError(
          photos: state.photos,
          metaData: state.metaData,
          failure: ExceptionFailure(),
          params: state.params,
        ));
      }
    }
  }
}
