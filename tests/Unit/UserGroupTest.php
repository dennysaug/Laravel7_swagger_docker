<?php

namespace Tests\Unit;

//use PHPUnit\Framework\TestCase;
use Tests\TestCase;
use App\UserGroup;

class UserGroupTest extends TestCase
{
    /**
     * A basic unit test example.
     *
     * @return void
     */
    public function testCreatingUserGroup()
    {
        $data = ['name' => 'Admin'];

        $response = $this->json('POST', 'api/user-group', $data);
        $response->assertStatus(201);
        $response->assertJsonStructure([
            'id',
            'name',
            'created_at',
            'updated_at'
        ]);
    }

    public function testGettingAllUserGroups()
    {
        $response = $this->json('GET', 'api/user-group');
        $response->assertStatus(200);

        $response->assertJsonStructure(
            [
                [
                    'id',
                    'name',
                    'created_at',
                    'updated_at'
                ]
            ]
        );
    }

    public function testGettingUserGroup()
    {
        $userGroup = UserGroup::all();

        $response = $this->json('GET', 'api/user-group/' .$userGroup[0]->id);
        $response->assertStatus(200);

        $response->assertJsonStructure([
            'id',
            'name',
            'created_at',
            'updated_at'
        ]);
    }

    public function testUpdatingUserGroup()
    {
        $userGroup = UserGroup::all();

        $data = ['name' => 'Test [edit]'];

        $response = $this->json('PUT', 'api/user-group/'.$userGroup[0]->id, $data);

        $response->assertStatus(200);

        $response->assertJson([
            'success' => true
        ]);
    }

    public function testDeletingUserGroup()
    {
        $userGroup = UserGroup::all();

        $response = $this->json('DELETE', 'api/user-group/'.$userGroup[0]->id);

        $response->assertStatus(200);

        $response->assertJson([
            'success' => true
        ]);
    }

    public function testCreatingNoData()
    {
        $data = [];

        $response = $this->json('POST', 'api/user-group', $data);
        $response->assertStatus(422);
    }
}
