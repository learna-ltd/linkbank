<tr>
    <td>
        <x-models.visibility-badge :model="$tag" class="d-inline-block me-1 small"/>
        <a href="{{ route('tags.show', ['tag' => $tag]) }}">
            <x-models.name-with-user :model="$tag"/>
        </a>
    </td>
    <td>
        {{ $tag->links_count }}
    </td>
    <td class="py-1">
        <div class="mt-1 d-flex align-items-center justify-content-end">
            <div class="btn-group me-1">
                <a href="{{ route('tags.edit', [$tag]) }}" class="btn btn-xs btn-link text-condensed">
                    @lang('linkace.edit')
                </a>
                <button type="submit" form="tag-delete-{{ $tag->id }}" title="@choice('tag.delete', 1)"
                    class="btn btn-xs btn-link text-condensed">
                    @lang('linkace.delete')
                </button>
            </div>
            <input type="checkbox" aria-label="Add link to bulk edit" class="bulk-edit-model form-check"
                data-id="{{ $tag->id }}">
        </div>

        <form id="tag-delete-{{ $tag->id }}" method="POST" style="display: none;"
            action="{{ route('tags.destroy', [$tag]) }}">
            @method('DELETE')
            @csrf
            <input type="hidden" name="redirect_back" value="1">
            <input type="hidden" name="tag_id" value="{{ $tag->id }}">
        </form>
    </td>
</tr>
