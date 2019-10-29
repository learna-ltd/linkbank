<?php

namespace App\Repositories;

use App\Models\LinkList;
use Illuminate\Support\Facades\Log;

class ListRepository
{
    /**
     * @param array $data
     * @return LinkList
     */
    public static function create(array $data): LinkList
    {
        $data['user_id'] = auth()->user()->id;

        return LinkList::create($data);
    }

    /**
     * @param LinkList $list
     * @param array    $data
     * @return LinkList
     */
    public static function update(LinkList $list, array $data): LinkList
    {
        $list->update($data);

        return $list;
    }

    /**
     * @param LinkList $list
     * @return bool
     */
    public static function delete(LinkList $list): bool
    {
        try {
            $list->links()->detach();
            $list->delete();
        } catch (\Exception $e) {
            Log::error($e);
            return false;
        }

        return true;
    }
}
