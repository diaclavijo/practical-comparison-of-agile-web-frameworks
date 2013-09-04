package com.myblog



import org.junit.*
import grails.test.mixin.*

@TestFor(BlogController)
@Mock(Blog)
class BlogControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/blog/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.blogInstanceList.size() == 0
        assert model.blogInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.blogInstance != null
    }

    void testSave() {
        controller.save()

        assert model.blogInstance != null
        assert view == '/blog/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/blog/show/1'
        assert controller.flash.message != null
        assert Blog.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/blog/list'

        populateValidParams(params)
        def blog = new Blog(params)

        assert blog.save() != null

        params.id = blog.id

        def model = controller.show()

        assert model.blogInstance == blog
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/blog/list'

        populateValidParams(params)
        def blog = new Blog(params)

        assert blog.save() != null

        params.id = blog.id

        def model = controller.edit()

        assert model.blogInstance == blog
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/blog/list'

        response.reset()

        populateValidParams(params)
        def blog = new Blog(params)

        assert blog.save() != null

        // test invalid parameters in update
        params.id = blog.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/blog/edit"
        assert model.blogInstance != null

        blog.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/blog/show/$blog.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        blog.clearErrors()

        populateValidParams(params)
        params.id = blog.id
        params.version = -1
        controller.update()

        assert view == "/blog/edit"
        assert model.blogInstance != null
        assert model.blogInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/blog/list'

        response.reset()

        populateValidParams(params)
        def blog = new Blog(params)

        assert blog.save() != null
        assert Blog.count() == 1

        params.id = blog.id

        controller.delete()

        assert Blog.count() == 0
        assert Blog.get(blog.id) == null
        assert response.redirectedUrl == '/blog/list'
    }
}
